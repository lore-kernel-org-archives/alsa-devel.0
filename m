From: Sebastien Bourdeauducq <sb@m-labs.hk>
Subject: baytrail-pcm-audio: audio broken on Lenovo Thinkpad
	Tablet 10
Date: Mon, 16 Feb 2015 23:24:00 -0700
Message-ID: <54E2DE80.1060308@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

the Thinkpad Tablet 10 has an impressive amount of problems under Linux, 
among which the audio is completely broken.

The kernel log is:
[    7.532413] rt5640 i2c-10EC5640:00: Device with ID register 6271 is 
not rt5640/39
[    7.908208] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio 
not registered
[    7.908231] platform byt-rt5640: Driver byt-rt5640 requests probe 
deferral
[    7.931549] baytrail-pcm-audio baytrail-pcm-audio: error: invalid DMA 
engine 0
[    7.931557] baytrail-pcm-audio baytrail-pcm-audio: sst_dma_new failed -22
[    7.967040] baytrail-pcm-audio baytrail-pcm-audio: FW version: 
04.05.13.a0
[    7.967047] baytrail-pcm-audio baytrail-pcm-audio: Build type: a0
[    7.967051] baytrail-pcm-audio baytrail-pcm-audio: Build date: Apr  2 
2014 14:14:39
[    7.967212] byt-rt5640 byt-rt5640: ASoC: CODEC DAI rt5640-aif1 not 
registered
[    7.967248] platform byt-rt5640: Driver byt-rt5640 requests probe 
deferral

I'm running kernel 3.19 with the latest firmware from the linux-firmware 
repository.

Sebastien
