From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to Configure Appropriate runtime->hw in
	ALSA	Driver
Date: Sun, 05 Jul 2015 19:20:04 +0200
Message-ID: <55996744.7040201@ladisch.de>
References: <CA+k7WwaxTObWDjn-7SqPkzTNNgf9+ManyT3mk8wDxLZZzn5OYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 84E1E260449
 for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2015 19:21:26 +0200 (CEST)
In-Reply-To: <CA+k7WwaxTObWDjn-7SqPkzTNNgf9+ManyT3mk8wDxLZZzn5OYQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Azizul Hakim <azizulfahim2002@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Azizul Hakim wrote:
> What is the best way to set the *runtime->hw* parameter in ALSA driver.

Set it to the capabilities of your hardware.

> From sample ALSA driver tutorial I understand we have to declare a
> *structure snd_pcm_hardware*  where we define all sound parameters
> like *STEREO/MONO,
> RATES* etc. Now at run time we can play sound files of different
> parameters. How ALSA behaves if the audio file parameters doesn't match
> with the *structure_snd_pcm_hardware* parameters?

Applications are not able to set unsupported parameter values.

However, alsa-lib can automatically convert rates/formats.

> If we want our driver to play any sound file

Your driver is supposed to driver your hardware.
What would you do with an unsupported format?


Regards,
Clemens
