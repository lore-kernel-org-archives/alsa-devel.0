From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: using ALSA one call
Date: Tue, 10 Feb 2009 16:04:05 +0100
Message-ID: <49919765.4000706@ladisch.de>
References: <1234269014.49917356f0157@mail.inbox.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C250A103834
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 16:04:09 +0100 (CET)
In-Reply-To: <1234269014.49917356f0157@mail.inbox.lv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kallipygos@inbox.lv
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

kallipygos@inbox.lv wrote:
> OK , this example works 
> http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm__min_8c-example.html
> but only if  samplerate = 48000; 
> if  samplerate = 44100 - then not :(
> 44k file play in 48k mode :D  it sounds funnee :D
> 
> I remixed this program so that it read data from wave file.
> 
> gcc  pcm_min01.c -lasound -O2  -o pcm_min01 
> ./pcm_min01  '/mnt/hda2/Booty Luv - Shine/Booty Luv - Shine (Ian Carey remix).wav'
> i gotta this :
> ALSA lib pcm.c:7160:(snd_pcm_set_params) Rate doesn't match (requested 44100Hz, get 0Hz)

Please show the source code of your program.


Best regards,
Clemens
