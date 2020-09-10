Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6499EC433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:57:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD91D20770
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XODr6rb0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xX5gJvPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD91D20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28D291661;
	Thu, 10 Sep 2020 10:56:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28D291661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599728260;
	bh=W3vn6IPX3x4GVD5wLkm0rOKmsSB3t0SDi1WFavSkmBY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XODr6rb0X3AkO5nMXkqcgVpbumPLN/5z8PWixk/dHIO3hLpk+8a0TiUzXCKGsZc1P
	 XYkxKB1iCBXIa/49prphYVIpi0gBHDxJ5AjToje246DwPNLz0aw4sLZejF0yN1g2bk
	 +YUMwO5elHXBGj6wG+Xng8Z9wswmxE9UqsVg9Jc0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8857FF80272;
	Thu, 10 Sep 2020 10:56:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2ABDF80277; Thu, 10 Sep 2020 10:56:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D9AAF80264
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 10:56:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D9AAF80264
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xX5gJvPE"
Received: from localhost (unknown [122.179.50.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 14DE420795;
 Thu, 10 Sep 2020 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599728193;
 bh=W3vn6IPX3x4GVD5wLkm0rOKmsSB3t0SDi1WFavSkmBY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xX5gJvPE3VQkbMWyrdAVGi6va/lGWrlV0vP3lDBsGO75pS7K4OynYGmUrI2V/0Sk+
 ot73jMr0fQeOPQZK/x9YAj50iADANGEUtaIuG1XJFLN7y4o8keq7eBFFkwcq74gRXR
 xhaQN4IehDjFgdIWeWEJO4kiuaP2Dgxg6CFX3krU=
Date: Thu, 10 Sep 2020 14:26:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
Message-ID: <20200910085621.GS77521@vkoul-mobl>
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
 <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
 <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
 <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
 <d0c71a83-9dc1-83c3-5cb1-d8fb7dc7f809@linaro.org>
 <ed88432c-e21c-b5fc-3abc-5f574769b722@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed88432c-e21c-b5fc-3abc-5f574769b722@linux.intel.com>
Cc: yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 09-09-20, 12:00, Pierre-Louis Bossart wrote:
> On 9/9/20 10:54 AM, Srinivas Kandagatla wrote:
> > On 09/09/2020 15:39, Pierre-Louis Bossart wrote:
> > > 
> > > > > > Currently slave devices are only added either from device tree or acpi
> > > > > > entries. However lets say, there is wrong or no entry of
> > > > > > a slave device
> > > > > > in DT that is enumerated, then there is no way for user to know all
> > > > > > the enumerated devices on the bus.
> > > > > 
> > > > > Sorry Srinivas, I don't understand your point.
> > > > > 
> > > > > The sysfs entries will include all devices that are
> > > > > described in platform firmware (be it DT or ACPI).
> > > > 
> > > > yes that is true, but it will not include all the enumerated
> > > > devices on the bus!
> > > > 
> > > > In my case on a new board I was trying to figure out what
> > > > devices are on the bus even before even adding any device tree
> > > > entries!
> > > 
> > > We've seen this before but dynamic debug provides all the
> > > information you need. see e.g. the logs from
> > > https://sof-ci.01.org/linuxpr/PR2425/build4447/devicetest/
> > > 
> > > jf-cml-rvp-sdw-1 kernel: [  289.751974] soundwire sdw-master-0:
> > > Slave attached, programming device number
> > > jf-cml-rvp-sdw-1 kernel: [  289.752121] soundwire sdw-master-0: SDW
> > > Slave Addr: 10025d070000 <<< HERE
> > 
> > Yes, I have noticed this too! This will be printed for every call to
> > sdw_extract_slave_id()!
> > 
> > ...
> > > 
> > > Now I get your point but
> > > a) you already have a dynamic debug trace to list all devices
> > > b) adding 'undeclared' devices would make things quite murky and is
> > > only half of the solution. We already struggle because we already
> > > have 'ghost' devices in sysfs that are not physically present, and
> > > no way to differentiate between the two. If we did add those
> > > entries, then we'd need two new sysfs attributes such as
> > > 'declared' and 'enumerated'.
> > 
> > I totally agree with you on dealing with the undeclared devices, which
> > is unnecessary mess!
> 
> It's not necessarily that bad.
> - if the intent is to have a single platform firmware that can deal with
> different boards, it's a good thing.
> - but if it's just sloppy platform firmware that just does copy-paste from
> platform to platform then indeed it becomes a mess.
> 
> > May be we could make the enumerated devices discovery bit more verbose!
> 
> Maybe adding a device number sysfs entry would help, e.g. reporting
> NotAttched or a value in [0,11] would tell you if the device is actually
> present.

Agreed, I cooked this patch to report verbose device status, let me know
if you are okay with this. I think this would be useful regardless of
current discussion.

On Db845c I see:

root@linaro-alip:/sys/bus/soundwire/devices# cat sdw:0:217:2010:0:1/status
Attached
root@linaro-alip:/sys/bus/soundwire/devices# cat sdw:0:217:2010:0:2/status
Attached

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index f510071b0add..3b2765f10024 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -97,8 +97,27 @@ static ssize_t modalias_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(modalias);
 
+#define SDW_SLAVE_MAX (SDW_SLAVE_RESERVED + 1)
+
+static const char *const slave_status[SDW_SLAVE_MAX] = {
+	[SDW_SLAVE_UNATTACHED] =  "UNATTACHED",
+	[SDW_SLAVE_ATTACHED] = "Attached",
+	[SDW_SLAVE_ALERT] = "Alert",
+	[SDW_SLAVE_RESERVED] = "Reserved",
+};
+
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+
+	return sprintf(buf, "%s\n", slave_status[slave->status]);
+}
+static DEVICE_ATTR_RO(status);
+
 static struct attribute *slave_attrs[] = {
 	&dev_attr_modalias.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(slave);

-- 
~Vinod
