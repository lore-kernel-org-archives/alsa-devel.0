From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 20/23] ASoC: add simple-graph-card document
Date: Tue, 18 Oct 2016 21:39:57 -0500
Message-ID: <CAL_Jsq+F6yKzbZu9BA9QTmiJne4OphZB12_AvLN3mC7vm__2+g@mail.gmail.com>
References: <87shrv4c8x.wl%kuninori.morimoto.gx@renesas.com>
 <87zim32xbo.wl%kuninori.morimoto.gx@renesas.com> <CAL_JsqJY-KtoR7C-vKBP1p3XRKkiVHBM9mzCdV3_P2DSp-xw9A@mail.gmail.com>
 <871szd3z8l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871szd3z8l.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2016 at 8:36 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi Rob
>
>> > +               type = "sound";
>>
>> I'm still not convinced this is necessary. This is implied either by
>> the fact there is only one port or perhaps the compatible string.
>
> Do you mean "on this sample" ? or in general ?
> Indeed this sample is definitely for sound, so type is very clear
> without property.
> But in general, for example HDMI, it want to know port type.
> Anyway, I can remove above "type" from this new sound driver.

For HDMI, the port number should dictate which one is video and which is audio.

>> > +rcar_sound {
>> > +       ...
>> > +       port {
>> > +               compatible = "asoc-simple-graph-card";
>> > +
>> > +               simple-audio-card,format = "left_j";
>> > +               simple-audio-card,bitclock-master = <&ak4643_port>;
>> > +               simple-audio-card,frame-master = <&ak4643_port>;
>>
>> Don't add a bunch of properties with in port and endpoint nodes. The
>> purpose is to describe the graph. Put these in the parent node or
>> perhaps the codec node.
>
> These properties are needed on each ports/endpoints on sound at this point.
> If ports/endpoints can't include these, I need to separate these,
> is it correct approach ? ?? see below

Uhh, no. Not at all what I had in mind.

> -- current style --
>
>         ports {
>                 compatible = "asoc-simple-graph-card";

I think your problems start with trying to extend simple-card. This
binding is anything but simple. I think using OF graph is a good idea,
but trying to make it completely generic is not.

>                 simple-audio-card,name = "graph-sound";
>
>                 port@0 {
>                         simple-audio-card,format = "left_j";
>                         simple-audio-card,bitclock-master = <&rcar_ak4613_port>;
>                         simple-audio-card,frame-master = <&rcar_ak4613_port>;

These look like properties of the ak4613 to me, so put them in the
ak4613 node. If they are standard property names, then you just walk
the graph and get them.

>
>                         type = "sound";
>                         rcar_ak4613_port: endpoint {
>                                 remote-endpoint = <&ak4613_port>;
>                                 playback = <&ssi0 &src0 &dvc0>;
>                                 capture  = <&ssi1 &src1 &dvc1>;

Not really sure how you are using these to comment.

>                         };
>                 };
>                 port@1 {
>                         simple-audio-card,format = "i2s";
>                         simple-audio-card,bitclock-master = <&rcar_hdmi0_port>;
>                         simple-audio-card,frame-master = <&rcar_hdmi0_port>;
>                         type = "sound";
>                         rcar_hdmi0_port: endpoint {
>                                 remote-endpoint = <&du_out_hdmi_snd0>;
>                                 playback = <&ssi2>;

If you are trying to describe a connection between hdmi_snd0 and ssi2,
then do just that. Add a port to ssi2 and connect it to hdmi_snd0.

>                         };
>                 };
>                 port@2 {
>                         simple-audio-card,format = "i2s";
>                         simple-audio-card,bitclock-master = <&rcar_hdmi1_port>;
>                         simple-audio-card,frame-master = <&rcar_hdmi1_port>;
>                         type = "sound";
>                         rcar_hdmi1_port: endpoint {
>                                 remote-endpoint = <&du_out_hdmi_snd1>;
>                                 playback = <&ssi3>;
>                         };
>                 };
>         };
>
> -- separate style --
>
>         ports {
>                 port@0 {
>                         rcar_ak4613_port: endpoint {
>                         }
>                 };
>                 port@1 {
>                         rcar_hdmi0_port: endpoint {
>                         }
>                 };
>                 port@2 {
>                         rcar_hdmi1_port: endpoint {
>                         }
>                 };
>         };
>
>         sound-xxx {
>                 compatible = "asoc-simple-graph-card";
>
>                 port@0 {
>                         simple-audio-card,format = "left_j";
>                         simple-audio-card,bitclock-master = <&rcar_ak4613_port>;
>                         simple-audio-card,frame-master = <&rcar_ak4613_port>;
>                 };
>                 port@1 {
>                         simple-audio-card,format = "i2s";
>                         simple-audio-card,bitclock-master = <&rcar_hdmi0_port>;
>                         simple-audio-card,frame-master = <&rcar_hdmi0_port>;
>                 };
>                 port@2 {
>                         simple-audio-card,format = "i2s";
>                         simple-audio-card,bitclock-master = <&rcar_hdmi1_port>;
>                         simple-audio-card,frame-master = <&rcar_hdmi1_port>;
>                 };
>         };
>
> Best regards
> ---
> Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
