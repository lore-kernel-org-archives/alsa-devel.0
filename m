From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: latest Mac Pro (quad core) audio issues
Date: Fri, 15 Aug 2008 09:54:12 -0700
Message-ID: <48A5B4B4.2060706@cox.net>
References: <775236.60926.qm@web65608.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao107.cox.net (fed1rmmtao107.cox.net [68.230.241.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 43AFB103890
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 18:54:14 +0200 (CEST)
In-Reply-To: <775236.60926.qm@web65608.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "S. Aguinaga" <sa_jr@ieee.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

S. Aguinaga wrote:
> Hello,
> 
> I just installed fedora (9) on one of the latest Mac Pro, all is well except for the audio.  I have no audio out of the main Tower speaker or via the headphones.  Eventually I want to drive audio out of the optical ports.  Any links to howto's or work-around would greatly appreciated.
> 
> // Salvador
> 
Fedora uses pulseaudio by default.  How are you determining that there 
is no output?  i.e. what program are you using, and how

Try aplay -vv some.wav
Try aplay -vv -Dhw:0,0 some.wav
Try aplay -vv -Dplughw:0,0 some.wav

Are there error messages or does it look like it is playing without 
sound?  Are there messages in /var/log/messages regarding sound at 
boot or while trying to play.

I don't use pulseaudio and don't know it very well, but there is more 
information here.  http://www.pulseaudio.org

Could you run a script which provides more information about your 
sound setup and post the link back here?

The script is found at http://www.alsa-project.org/alsa-info.sh

You can run the script so the results occur locally, by specifying the 
   ---no-upload   option.

alsa-info.sh --no-upload

You would then paste the output into your email instead of providing a 
link.

This information will enable me to determine if your setup is OK, and 
look for other problems.
