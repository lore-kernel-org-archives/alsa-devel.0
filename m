From: "Michel Benoit" <murpme@gmail.com>
Subject: default PCM volume
Date: Tue, 15 May 2007 10:11:18 +0200
Message-ID: <c88e466f0705150111x4a9f8e0cy5b908a30721ccea0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 32AD6244F5
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 10:11:20 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so47292nzf
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2007 01:11:18 -0700 (PDT)
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

Hello again,

I am running alsa on a custom AT91SAM9260 arm based SOC board together
with a a simple external PCM1725 codec.  When using alsa-lib and the
at91 soc driver (pcm+i2s) I can playback PCM samples using both aplay
and test/pcm.  Using softvol I can also reduce the volume of the
playback.

The problem I have is that the playback volume (with softvol=100%) is
not very loud.  The volume is the same even without the softvol
plugin. The PCM codec has no hw volume control.   According to our hw
team the sound level should be much higher.

Is there a default PCM attenuation (volume reduction) built into alsa
lib?  If so, how can it be adjusted?

Thanks,

Michel
