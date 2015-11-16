From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Mon, 16 Nov 2015 14:28:13 +0000
Message-ID: <20151116142813.GF18889@ck-lbox>
References: <20151113225355.GU12392@sirena.org.uk>
 <20151114074400.GA7898@amd>
 <20151114123931.GW12392@sirena.org.uk>
 <20151114175915.GA20429@amd>
 <20151114184940.GY12392@sirena.org.uk>
 <20151114211633.GE20429@amd>
 <20151115001402.GZ12392@sirena.org.uk>
 <20151116074534.GA5606@amd>
 <20151116105035.GA31303@sirena.org.uk>
 <20151116122947.GA9125@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151116122947.GA9125@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Brown <broonie@kernel.org>, sameo@linux.intel.com, lee.jones@linaro.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 16, 2015 at 01:29:47PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > Every single sound driver gets this right, none of them assume the name
> > > > is global.  What makes you say that they assume names are global?
> > 
> > > Ok, so you are saying that if I fix mfd initialization, sound will
> > > automagically switch from global regulators to device-specific
> > > regulators and things will start working?
> > 
> > Yes.
> 
> Ok, so something like this should be applied?
> 
> (I'm not sure how to test it, as audio works before and after the
> patch.)

Well I guess the first test is do these error messages you where
getting disappear:

> [    2.734198] wm5102-codec.1 supply MICVDD,spi32766.1 not found, using dummy regulator
> [    3.170912] wm5102-codec.2 supply MICVDD,spi32766.2 not found, using dummy regulator

I think what we are missing here is looking at why the lookup is
actually failing. I have had a look at the code, but I don't see
an obvious reason why having a second CODEC would cause the
supply lookup to fail.

Can you please apply this diff and provide a log so we can have a
look at what is going on with the supply aliasing:


diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7181ffd..f1c8897 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1345,9 +1345,11 @@ static struct regulator_supply_alias *regulator_find_supply_alias(
 {
 	struct regulator_supply_alias *map;
 
-	list_for_each_entry(map, &regulator_supply_alias_list, list)
+	list_for_each_entry(map, &regulator_supply_alias_list, list) {
+		dev_err(dev, "Checking %s,%p\n", map->src_supply, map->src_dev);
 		if (map->src_dev == dev && strcmp(map->src_supply, supply) == 0)
 			return map;
+	}
 
 	return NULL;
 }
@@ -1356,11 +1358,12 @@ static void regulator_supply_alias(struct device **dev, const char **supply)
 {
 	struct regulator_supply_alias *map;
 
+	dev_err(*dev, "Looking for %s,%p\n", *supply, *dev);
 	map = regulator_find_supply_alias(*dev, *supply);
 	if (map) {
-		dev_dbg(*dev, "Mapping supply %s to %s,%s\n",
+		dev_err(*dev, "Mapping supply %s to %s,%p\n",
 				*supply, map->alias_supply,
-				dev_name(map->alias_dev));
+				map->alias_dev);
 		*dev = map->alias_dev;
 		*supply = map->alias_supply;
 	}
@@ -1796,8 +1799,8 @@ int regulator_register_supply_alias(struct device *dev, const char *id,
 
 	list_add(&map->list, &regulator_supply_alias_list);
 
-	pr_info("Adding alias for supply %s,%s -> %s,%s\n",
-		id, dev_name(dev), alias_id, dev_name(alias_dev));
+	pr_info("Adding alias for supply %s,%p -> %s,%p\n",
+		id, dev, alias_id, alias_dev);
 
 	return 0;
 }

Thanks,
Charles
