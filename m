From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Query regarding external alsa plugins
Date: Mon, 10 Dec 2007 13:02:53 +0530
Message-ID: <61445c750712092332sdd2368dr7788df16fb95a2ee@mail.gmail.com>
References: <61445c750712070220s1185cea2qd4624affee80af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id E8DBC1038D2
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 08:32:56 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so3257145wag
	for <alsa-devel@alsa-project.org>; Sun, 09 Dec 2007 23:32:55 -0800 (PST)
In-Reply-To: <61445c750712070220s1185cea2qd4624affee80af1@mail.gmail.com>
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

On Dec 7, 2007 3:50 PM, Pharaoh . <pharaoh137@gmail.com> wrote:

> Hi
>
> I am writing an external IO type plugin for my board since my audio driver
> is going to be a user space driver
> i.e. no alsa kernel driver because of some technical reasons. My pluging
> works okay and now I want to provide
> a mixer control interface like volume control and playback path  selection
> etc.
>
> Is there anything like mixer plugin etc which can be intergrated with my
> existing plugin? Can I get a test code
> somewhere?
>

To further elaborate my question , when I do an aplay the control comes to
my plugin and I can play the audio samples, but I want to some mechanism
using which,

#amixer -D my_control_plugin cset numid=1 100 //say volume control

should also come to my plugin, a control plugin may be? How do I do this, I
dont know any way to specify the plugin path while using amixer command.

-pharaoh
