From: Holger Dehnhardt <dehnhardt@ahdehnhardt.de>
Subject: Re: MTP-AV Bugs
Date: Wed, 11 Feb 2009 14:18:59 +0100
Message-ID: <200902111418.59819.dehnhardt@ahdehnhardt.de>
References: <200902102154.32301.dehnhardt@ahdehnhardt.de>
	<s5hhc3118i1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahdehnhardt.de (ahdehnhardt.de [88.80.200.198])
	by alsa0.perex.cz (Postfix) with ESMTP id E6B6A24499
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 14:19:11 +0100 (CET)
Received: from [213.61.126.111] (helo=dehnhardtlin.localnet)
	by ahdehnhardt.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63) (envelope-from <dehnhardt@ahdehnhardt.de>)
	id 1LXEzd-0004Yq-Oz
	for alsa-devel@alsa-project.org; Wed, 11 Feb 2009 14:19:13 +0100
In-Reply-To: <s5hhc3118i1.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Takashi,

thank you for your quick response!
See my inline comments.

Am Mittwoch, 11. Februar 2009 13:08:22 schrieb Takashi Iwai:
> At Tue, 10 Feb 2009 21:54:32 +0100,
>
> Holger Dehnhardt wrote:
> > After some time I found the following bug:
> >
> > static void snd_mtpav_inmidi_h(struct mtpav *mcrd, u8 inbyte)
> > {
> >         if (inbyte >= 0xf8) {
> >                 /* real-time midi code */
> > -->                snd_mtpav_inmidi_process(mcrd, inbyte);
> > 	//here the inmidiport is not translated to the prtnumber, so
> > 	// snd_mtpav_inmidi_process the port with an index of some 80000
> > 	// in the ports array of the mtpav struct was called
>
> Good catch.  I think the patch below should fix the problem
>
> > The following change made the driver work:
> > static void snd_mtpav_inmidi_h(struct mtpav *mcrd, u8 inbyte)
> > {
> >         if (inbyte >= 0xf8) {
> >                 /* real-time midi code */
> > 		mcrd->inmidiport = translate_hwport_to_subdevice(mcrd, inbyte);
>
> This isn't correct since inbyte is supposed to be under 0x13.

Sorry, I don't understand what you mean: inbyte should always be lower than 
0x13 or is the real time midi code always lower then 0x13? 

>
> > After that I realised, that with the recent driver - even without my
> > change - playing midi files din not work anymore.
> > Only the first midi event was sent to the interface, everything else was
> > dropped somewhere.
> >
> > So a diff between the last workin version and the recent version showed
> > only one change:
>
> What was the last working version exactly?

1.0.18 (from the debian experimental repository)

--snip

Holger
