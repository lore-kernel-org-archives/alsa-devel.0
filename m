From: Daniel Mack <zonque@gmail.com>
Subject: Re: alsa usb audio class 2
Date: Tue, 28 Feb 2012 10:02:44 +0100
Message-ID: <4F4C9834.1000704@gmail.com>
References: <CAD=zES=Q48Tw7qKUr6CNavgo078=qzGSDMs26VNToCg4jU86Kg@mail.gmail.com>
	<s5h1upgs4je.wl%tiwai@suse.de>
	<CAD=zES=rQsb+1q=-dtALx78j=YWJo-rnAfd+5ZmyFw_sS1AZmw@mail.gmail.com>
	<s5hsjhwqod5.wl%tiwai@suse.de>
	<CAD=zESkJWAaDVS29+Nr0aHr_zeX59nFPXxLrXD=sEGfU9eTPxA@mail.gmail.com>
	<s5hobskqns8.wl%tiwai@suse.de>
	<CAD=zESk77H3maWTTaNWTqiCTAoLa7yO=1ehoQMZq50_ZGW58Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id BD5E324141
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 10:02:50 +0100 (CET)
Received: by bkty7 with SMTP id y7so4288131bkt.38
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 01:02:50 -0800 (PST)
In-Reply-To: <CAD=zESk77H3maWTTaNWTqiCTAoLa7yO=1ehoQMZq50_ZGW58Uw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Markus Bollinger <bollinger@digigram.com>
List-Id: alsa-devel@alsa-project.org

On 28.02.2012 09:57, Markus Bollinger wrote:
> OK, thank you Takashi.
> I attached the log file of the 'lsusb -v' output

Thanks for the dump. Are there any kernel messages that are generated
when plugging in the device? Check with 'dmesg'.

Also, from the dump I can see that some string descriptors are really
broken in this device. Don't know if that causes your trouble though.


Daniel
