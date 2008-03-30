From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Sun, 30 Mar 2008 23:02:40 +1300
Message-ID: <47EF6540.1020808@orcon.net.nz>
References: <20080330051814.5D9CCDBA2@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx4.orcon.net.nz (mx4.orcon.net.nz [219.88.242.54])
	by alsa0.perex.cz (Postfix) with ESMTP id A909E245C9
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Mar 2008 12:02:44 +0200 (CEST)
Received: from Debian-exim by mx4.orcon.net.nz with local (Exim 4.68)
	(envelope-from <mcree@orcon.net.nz>) id 1JfuN9-0001Sg-Bo
	for alsa-devel@alsa-project.org; Sun, 30 Mar 2008 23:02:43 +1300
In-Reply-To: <20080330051814.5D9CCDBA2@gherkin.frus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bob Tracy <rct@frus.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Bob Tracy wrote:
> Rene Herman wrote:
>> $ sox asskickd.wav -w -r 44100 -t alsa hw
> 
> Several seconds of silence, followed by what sounded like continuous pitched
> machine-gun fire.  Each <ctrl>C advanced through the file (the pitch of the
> machine-gun fire changed slightly).  Still had to type <ctrl>\ to kill sox.

Right, that sounds just like the older PWS600au I have - the one with 
the ESS1888 - except that what Bob describes as machine gun fire, I 
thought was, ahem, flatulence.

The newer PWS600au (with the ESS1887) plays the sound files correctly, 
except for the repeated bits at the end.

Michael.
