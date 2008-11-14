From: "Bankim Bhavsar" <bankim.bhavsar@gmail.com>
Subject: Using period events
Date: Fri, 14 Nov 2008 13:35:08 -0800
Message-ID: <4eccebac0811141335p6e26b633iadb0c3418e6d0a2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by alsa0.perex.cz (Postfix) with ESMTP id 1EAFF243CF
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 22:35:09 +0100 (CET)
Received: by gxk9 with SMTP id 9so846802gxk.8
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 13:35:08 -0800 (PST)
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
Cc: mzjro@0pointer.net, bbhavsar@vmware.com
List-Id: alsa-devel@alsa-project.org

Hi,
I used async notification mechanism provided by alsa-lib. Since they
use signals I ran into all sorts of issues. I should have read this
post before http://mailman.alsa-project.org/pipermail/alsa-devel/2008-May/008030.html
Definitely not the way to go ahead. I second the argument to remove
that feature from alsa-lib altogether.

We need a mechanism wherein the alsa subsystem notifies a polling
thread that a "period" of sound bytes has been completed.
Using snd_pcm_sw_params_set_period_event() will suffice?

I took a cursory look at the alsa-lib and it seems a timer is used for
this purpose. Is this well supported on majority of sound cards out
there (alsa version 1.0.17+)?
I want to make sure before I use this alternative approach.

Thanks,
Bankim.
