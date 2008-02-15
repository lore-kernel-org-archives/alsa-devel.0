From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Random inverted audio channels
Date: Fri, 15 Feb 2008 17:39:49 +0100
Message-ID: <40617.1755785637$1203093650@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 3AE67246A9
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 17:39:53 +0100 (CET)
Content-Language: fr
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

Hi alsa-devel list,

I'm currently working on an internal project. 
Here is some details :
This embedded project includes a AT91SAM9260 CPU and a WM8900 codec.
Audio driver is using ASoC API. 
Audio data could be either switch from I2S or DSP A, but I prefer the second
one.
Audio Codec is master.

We have an issue : when we play a right channel stereo track, sound is
played on right channel, but sometimes on left.
This issue could happen right after starting kernel, or later after 10-20
sounds played.
With Frank Mandarino, we've checked any issue from SSC(audio bus) or PDC
(dma) controlers, but no much success.

Any idea to help us debugging this issue would be welcome !

Regards,
Alex.
