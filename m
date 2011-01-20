From: Anisse Astier <anisse@astier.eu>
Subject: Re: hda : computer using EAPD as external amplifier
 controller
Date: Thu, 20 Jan 2011 11:00:06 +0100
Message-ID: <20110120110006.742da7cc@destiny.ordissimo>
References: <20110119182448.2c8dbf28@destiny.ordissimo>
	<4D37FB6B.9040701@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f193.google.com (mail-wy0-f193.google.com
	[74.125.82.193])
	by alsa0.perex.cz (Postfix) with ESMTP id C3B94103A56
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 11:00:33 +0100 (CET)
Received: by wyb42 with SMTP id 42so129061wyb.8
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 02:00:33 -0800 (PST)
In-Reply-To: <4D37FB6B.9040701@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi David,

On Thu, 20 Jan 2011 10:07:55 +0100, David Henningsson <david.henningsson@canonical.com> wrote :

> On 2011-01-19 18:24, Anisse Astier wrote:
> >
> >  From what I've seen in patch_realtek, it seems we need to write the whole
> > config for the device when adding a quirk: we can't rely on auto
> > configuration and then put a small quirk on top of that. Am I right ?
> 
> Perhaps this commit can give you some inspiration?
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=357f915ece53aa4c8759087888346145848ea753
> 
> ...although Takashi just rewrote the quirking system a bit, so you'll 
> have to adjust to that when you add your (similar) quirk.

Well, I was wrong, thanks a lot for pointing me in the right direction !
Just did a rebase of sound-2.6/for-next branch and read Takashi's followup
email, fix should be trivial, a patch will follow soon. 

Regards,
Anisse
