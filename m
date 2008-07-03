From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] ALSA SoC: Add OpenFirmware helper
	for	matching bus and codec drivers
Date: Thu, 3 Jul 2008 10:33:51 -0600
Message-ID: <20080703163351.GJ2284@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<9e4733910807020827k115fe63r7a0dd09daffc1895@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 32EDF24945
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 18:34:25 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so244541yxh.2
	for <alsa-devel@alsa-project.org>; Thu, 03 Jul 2008 09:34:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e4733910807020827k115fe63r7a0dd09daffc1895@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 02, 2008 at 11:27:17AM -0400, Jon Smirl wrote:
> On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> >  +static struct of_snd_soc_device *
> >  +of_snd_soc_get_device(struct device_node *codec_node)
> >  +{
> >  +       struct of_snd_soc_device *of_soc;
> >  +
> >  +       list_for_each_entry(of_soc, &of_snd_soc_device_list, list) {
> >  +               if (of_soc->codec_node == codec_node)
> >  +                       return of_soc;
> >  +       }
> >  +
> >  +       of_soc = kzalloc(sizeof(struct of_snd_soc_device), GFP_KERNEL);
> >  +       if (!of_soc)
> >  +               return NULL;
> >  +
> >  +       /* Initialize the structure and add it to the global list */
> >  +       of_soc->codec_node = codec_node;
> >  +       of_soc->id = of_snd_soc_next_index++;
> >  +       of_soc->machine.dai_link = &of_soc->dai_link;
> >  +       of_soc->machine.num_links = 1;
> >  +       of_soc->device.machine = &of_soc->machine;
> >  +       of_soc->dai_link.ops = &of_snd_soc_ops;
> >  +       list_add(&of_soc->list, &of_snd_soc_device_list);
> >  +
> >  +       return of_soc;
> >  +}
> 
> Isn't this performing the same basic function as this code (except for
> spi)? Should this list be maintained in alsa or should there be an
> equivalent for searching the spi bus? If you follow the link to the
> codec node and get it's parent you know which bus to search. But it
> might be simpler to just search the buses sequentially for the node.
> 
> static int of_dev_node_match(struct device *dev, void *data)
> {
>         return dev->archdata.of_node == data;
> }
> 
> struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
> {
> 	struct device *dev;
> 	
> 	dev = bus_find_device(&i2c_bus_type, NULL, node,
> 					 of_dev_node_match);
> 	if (!dev)
> 		return NULL;
> 		
> 	return to_i2c_client(dev);
> }
> EXPORT_SYMBOL(of_find_i2c_device_by_node);

Yes, but you hadn't written these functions when I wrote this helper.
:-P.  I believe ASoC v2 makes all this stuff unnecessary, but I'm
waiting for v2 to hit mainline before I port forward.

g.
