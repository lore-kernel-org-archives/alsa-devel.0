From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [git pull] [PATCH 0/7] add support for many Roland
 and Yamaha devices
Date: Sun, 11 Aug 2013 14:15:32 +0200
Message-ID: <52078064.3090409@ladisch.de>
References: <51CC9D8B.7060601@ladisch.de> <4161390.DqJ0fEoIrV@kamdesktop>
 <52053269.2050706@ladisch.de> <2663331.bA47oXYmkZ@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5F43E2616E1
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 14:15:55 +0200 (CEST)
In-Reply-To: <2663331.bA47oXYmkZ@kamdesktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Keith A. Milner" <maillist@superlative.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Keith A. Milner wrote:
> $ aplay -Dhw:3 -fS16_LE -c2 -r44100 Test.wav

aplay reads the format/channels/rate settings from the .wav file and
ignores your parameters.

> Playing WAVE 'Test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
> aplay: set_params:1081: Sample format not available

Use "plughw" instead of "hw" to get automatic format conversion.


Regards,
Clemens
