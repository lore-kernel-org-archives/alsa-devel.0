From: Harald Radke <harryrat@postnuklear.de>
Subject: Re:
 =?iso-8859-1?q?CORRECTION_=28get_rid_of_controls_wit?=
 =?iso-8859-1?q?h=09snd=5Fctl=5Fremove_=29?=
Date: Tue, 2 Sep 2008 10:02:13 +0200
Message-ID: <200809021002.13540.harryrat@postnuklear.de>
References: <200808291454.42441.harryrat@postnuklear.de>
	<200809011309.22478.harryrat@postnuklear.de>
	<1220269870.6499.107.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.netbeat.de (mail.netbeat.de [83.243.58.160])
	by alsa0.perex.cz (Postfix) with SMTP id C44AA24635
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 10:02:19 +0200 (CEST)
In-Reply-To: <1220269870.6499.107.camel@odin>
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

Am Montag 01 September 2008 13:51:10 schrieb Liam Girdwood:
> On Mon, 2008-09-01 at 13:09 +0200, Harald Radke wrote:
> > Ok, I just checked my source and  realized I messed things up...
> >
> > deactivating AND activating work, the control is not accessible via
> > mixer, however sound paths the control is related to still are functional
>
> That's good to hear that things are working. The sound paths that are
> related to disabled controls may still need to be functional depending
> on the audio use case.

Well, actually that is exactly what I need, so this wasn't a complain (: as I 
e.g. want to deactivate all mixer device settings in mixer utils, however, set 
the mixer DAC input correctly. If deactivated controls were breaking 
soundpaths, I had to "rewire" them...

Hm, a great thing would be to have something like "codec_instanciate()" where 
u could select a codec device and an array with control names and values for 
items to be deactivated and get the "modified" codec...but I guess that would 
be ways to high level for the sound driver structure (;


Greez,

Harry

PS: keep up ur great work folks and thank you!
