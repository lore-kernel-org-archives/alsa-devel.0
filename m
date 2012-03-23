From: =?UTF-8?B?0J/QsNCy0LXQuyDQmtC+0LvQvtC00LjQvQ==?= <pavelkolodin@gmail.com>
Subject: ALSA async callback re-enter and DEADLOCK.
Date: Sat, 24 Mar 2012 02:22:18 +0300
Message-ID: <CACwG4MQMn_KjiP9eUbiqJEMW5eF40+aOvcGM=fhSs8SPPgaE=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AE03C103A5A
	for <alsa-devel@alsa-project.org>; Sat, 24 Mar 2012 00:20:45 +0100 (CET)
Received: by iakh37 with SMTP id h37so5531523iak.38
	for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2012 16:22:18 -0700 (PDT)
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

Hello.

I've implemented a simple application using this example:
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html (see
"async_callback()", line 390).

My problem is that sometimes (after 1 or 20 mins of playing sound
(unpredictable) everything just hangs - similarly to deadlock. I have found
that callback is called WHILE another callback function is still executed
(not returned yet). My debug code is like:

void async_callback(snd_async_handler_t *ahandler)
{
    std::cout << "?"; std::cout.flush();
    // some code with snd_async_handler_get_callback_private(),
snd_pcm_avail_update(), snd_pcm_writei() and so on //
    std::cout << "!"; std::cout.flush();
    return;
}

Everything is ok when i see "?!?!?!...", but if "??" occurs than app goes
into an eternal deadlock.

I work with ALSA literally as in that example - settings (HW and SW) are
the same. Soundcard is "Analog Devices AD1981", ALSA version is 1.0.19. I
do fill buffer until there is a place for periods and hear
44100/16/2channels sound without any clicks and noises before "??" occurs.

Sorry for poor english; from Siberia with love.
Thank you!
