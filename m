From: Jacopo De Simoi <jacopods@gmail.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_-_hda_intel_conextant_1/1=5D?=
 =?iso-8859-1?q?_Fixed_microphone=09mixer_for_HP_Compaq_Presario_F700_Adde?=
 =?iso-8859-1?q?d_conextant_patch_for=09Hewlett-Packard_Company_Device_Sub?=
 =?iso-8859-1?q?system_id_-_103c=3A30ea?=
Date: Sun, 24 Jan 2010 14:59:10 +0100
Message-ID: <201001241459.10484.jacopods@gmail.com>
References: <1262565656-2737-1-git-send-email-knprox@mi.rr.com>
	<s5hvdf766a1.wl%tiwai@suse.de> <s5h4ombbxok.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A7F324434
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 12:33:41 +0100 (CET)
Received: by ewy5 with SMTP id 5so7147564ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 03:33:41 -0800 (PST)
In-Reply-To: <s5h4ombbxok.wl%tiwai@suse.de>
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

I can confirm that this patch applies to HP dv2700 subsystem 103c:30d6 (at least with 
-	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1) | 0x03},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x03},
 ). 

Node 0x14 supports multiple connections to 0x17 (0x01) and 0x1d (0x00); 0x1d is apparently not working; 
Also, I don't understand if 0x15-0x18 are working. It doesn't do anything here, but it might be stuff from the expansion slot (?)


On Sunday 24 January 2010 11:32:27 Takashi Iwai wrote:
> At Tue, 12 Jan 2010 10:07:02 +0100,
> I wrote:
> > 
> > At Fri, 8 Jan 2010 09:09:54 +0100 (CET),
> > Jaroslav Kysela wrote:
> > > 
> > > On Sun, 3 Jan 2010, knprox@mi.rr.com wrote:
> > > 
> > > > From: Ken Prox <kprox@users.sourceforge.net>
> > > >
> > > >
> > > > Signed-off-by: Ken Prox <kprox@users.sourceforge.net>
> > > 
> > > I've applied your patch to my "devel" git tree with space/tab 
> > > replacements. Please, use same coding style matching other ALSA code and 
> > > run "scripts/checkpatch.pl" on your patch before posting. Thanks.
> > 
> > I pulled your branches now to sound git tree.
> 
> And, now I'm checking the code and your change again while I'm working
> on fixing / clean-up of cxt5051 code.  I don't understand why your patch
> works.  Does it really work as is?
> 
> For example, the pin 0x17 has no multiple connections.  So, changing
> the amp for the input #1 doesn't make sense at all.  If it supports only
> the pin 0x1d, then the init verbs have to be different.
> 
> Doesn't another model, e.g. model=hp-dv6736, work as is?
> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
