From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: .asoundrc
Date: Mon, 18 Jun 2007 16:04:04 +0530
Message-ID: <8d6898730706180334j27251fccm80c30894c931898f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 82C6824366
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 12:34:06 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1251876nzf
	for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2007 03:34:05 -0700 (PDT)
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
To: alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Seth Forshee <seth.forshee@gmail.com>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to write one .asoundrc file

What i am currently doing is rate conversion

My .asounrc file contains

pcm.sirf3a {
        type rate
        slave {
                pcm "hw:0,0"
                rate 8000
        }
}


I am using following command

aplay -M -D sirf3a /usr/share/sounds/alsa/Side_Right.wav

But it is giving me some errors

aplay: set_params:909: Channels count non available

Any idea why this?
where I am going wrong?
