From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 15:16:31 +0200
Message-ID: <CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name> <4E537524.9010303@ladisch.de>
	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name>
	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>
	<4E53A748.4070404@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 43BCD1039FD
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 15:16:33 +0200 (CEST)
Received: by ywt32 with SMTP id 32so63783ywt.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2011 06:16:32 -0700 (PDT)
In-Reply-To: <4E53A748.4070404@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 23, 2011 at 3:12 PM, Kristian Amlie <kristian@amlie.name> wrote:
> Here is the output from one complete run of cu, including connecting,
> pressing a key once on the instrument and killing cu afterwards:
>
> [20380.847492] change_speed(): urb_value: 16696, urb_index: 0
> [20380.849364] update_mctrl(): urb_value: 771, priv->interface: 0
> [20380.851360] change_speed(): urb_value: 49230, urb_index: 0
> [20380.854412] change_speed(): urb_value: 49230, urb_index: 0
> [20380.857361] change_speed(): urb_value: 49230, urb_index: 0
> [20387.615704] change_speed(): urb_value: 16696, urb_index: 0
> [20387.619557] update_mctrl(): urb_value: 768, priv->interface: 0

And now once again without killing cu, please. I'm interested in the
last commands that occur before the device starts working.

Daniel
