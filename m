From: Bankim Bhavsar <bankim.bhavsar@gmail.com>
Subject: Questions regarding workaround for VMware
Date: Fri, 28 Aug 2009 11:29:52 -0700
Message-ID: <4eccebac0908281129n1b2206bbo37ea80e64d4d1d4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C6D9103808
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 20:30:14 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so770912anc.2
	for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2009 11:30:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, akataria@vmware.com, bbhavsar@vmware.com
List-Id: alsa-devel@alsa-project.org

Takashi I came across a workaround for VMware in ALSA kernel code
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=79452f0a28aa5a40522c487b42a5fc423647ad98

Thanks for the fix.

In the comments you mention about inaccurate timer source.
Could you elaborate on the problem?

As of now we see that sound apps running in Fedora 11 guest OS with
kernel 2.6.29.4-167 don't make any progress and can hang window
manager like Metacity.

VMware virtualizes Ensoniq ES1371 sound device.

Is there something specific you would like us to fix in our virtual
sound device or timer source?

Thanks,
Bankim.
