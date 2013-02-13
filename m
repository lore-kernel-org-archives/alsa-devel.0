From: Anil Kumar <anilk4.v@gmail.com>
Subject: Re: Use of of_parse_phandle()/of_node_put()
Date: Wed, 13 Feb 2013 22:32:11 +0530
Message-ID: <CABYxbz7_9cwgswHq2Pq3BWx-8-c0tkJNW8z16u45+pAJV6YS0w@mail.gmail.com>
References: <F3DBB1B3EF102E4994C89758CFCA32412C6E52@DBDE01.ent.ti.com>
	<511BB6C2.3060105@ti.com>
	<CABYxbz6xEEVxL1BBM+Mb7net27d3zTD-6+uoS63LXXvifn_TNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CABYxbz6xEEVxL1BBM+Mb7net27d3zTD-6+uoS63LXXvifn_TNw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "Kumar, Anil" <anilkumar.v@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "jarkko.nikula@bitmer.com" <jarkko.nikula@bitmer.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alsa Devel List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On Wed, Feb 13, 2013 at 10:10 PM, Anil Kumar <anilk4.v@gmail.com> wrote=
:
> Hi,
>
> On Wed, Feb 13, 2013 at 9:22 PM, Peter Ujfalusi <peter.ujfalusi@ti.co=
m> wrote:
>> On 02/13/2013 07:04 AM, Kumar, Anil wrote:
>>> Hi  Peter,
>>>
>>> Just trying to understand.
>>>
>>> In omap-twl4030.c file probe function :-
>>>
>>> dai_node =3D of_parse_phandle(node, "ti,mcbsp", 0);
>>>                 if (!dai_node) {
>>>                         dev_err(&pdev->dev, "McBSP node is not prov=
ided\n");
>>>                         return -EINVAL;
>>>                 }
>>>
>>> Here  =93of_parse_phandle()=94  is used to get  =93of_device=94 nod=
e pointer.
>>> of_parse_phandle() suggest to use of_node_put()  on it when done.
>>>
>>> It looks when code request for an =93of_device=94 node, kernel  mai=
ntains
>>> =93refcount=94 for this.
>>> It check =93refcount=94  before giving pointer of of_device node an=
d  WARN_ON()
>>> in case of refcount  > 0 and increase it on success.
>>>
>>> Should this code need to use of_node_put() on the requested =93of_d=
evice=94 when done
>>> so that this can be get  again ?
>>
>> Hrm, one thing or sure we should not call it of_node_put() while we =
have the
>> card loaded since the node is used runtime by the core.
>>
>> However when we unload the machine driver it might be needed, but no=
t sure
>> about this. None of the existing machine drivers doing it (tegra, sa=
msung,
>> omap, etc).
>> But if it is needed it might be better to be done by the core?
>>

Sorry i forgot to mention.

Yes, I think soc core may have something like[1] to release cpu_of_node=
=2E

[1]
------------8---------------
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b7e84a7..9000f4a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1044,6 +1044,13 @@ static void soc_remove_dai_links(struct
snd_soc_card *card)
                        soc_remove_link_dais(card, dai, order);
        }

+       /* release cpu_of_node */
+       if(card->dai_link) {
+               int i;
+               for(i =3D 0; i < card->num_links; i++)
+                       of_node_put(card->dai_link[i].cpu_of_node);
+       }
+

Thanks,
Anil

>
> It looks issue is different here.
> I have done some testing here with patch[1]. In this patch i tried to
> get same "of_device" node pointer
> again and found refcount for this dt node is 1 [Result].
>
> As of_parse_phandle() says it "returns the device_node pointer with
> refcount incremented".
> But why refcount  value is 1 [Result] again ?
>
> -----------------------------8---------------------
> Patch[1]:-
> diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4=
030.c
> index fd98509..0828a5c 100644
> --- a/sound/soc/omap/omap-twl4030.c
> +++ b/sound/soc/omap/omap-twl4030.c
> @@ -297,6 +297,16 @@ static int omap_twl4030_probe(struct platform_de=
vice *pdev)
>                         dev_err(&pdev->dev, "McBSP node is not provid=
ed\n");
>                         return -EINVAL;
>                 }
> +               printk(KERN_ERR"refcount 0x%x",
> atomic_read(&dai_node->kref.refcount));
> +
> +               dai_node =3D of_parse_phandle(node, "ti,mcbsp", 0);
> +                if (!dai_node) {
> +                        dev_err(&pdev->dev, "McBSP node is not provi=
ded\n");
> +                        return -EINVAL;
> +                }
> +               printk(KERN_ERR"refcount 0x%x",
> atomic_read(&dai_node->kref.refcount));
> +
> +
>                 omap_twl4030_dai_links[0].cpu_dai_name  =3D NULL;
>                 omap_twl4030_dai_links[0].cpu_of_node =3D dai_node;
>
> [Result]:-
> root@DevKit8000:/# insmod snd-soc-omap-twl4030.ko
> [   95.718109] refcount 0x1
> [   95.720611] refcount 0x1 [   95.818054] omap-twl4030 sound.20:
> twl4030-hifi <-> 49022000.mcbsp mapping ok
>
>
> Thanks,
> Anil
> [...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
