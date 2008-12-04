From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: question for the all-knowing - firewire audio
	hardware
Date: Thu, 4 Dec 2008 12:14:58 +0000
Message-ID: <20081204121458.GA2383@localhost>
References: <805474.11224.qm@web65609.mail.ac4.yahoo.com>
	<20081203182423.GA2459@localhost>
	<747517.674.qm@web65606.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id CFD6F24353
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 13:02:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <747517.674.qm@web65606.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "S. Aguinaga" <sa_jr@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 03, 2008 at 02:28:43PM -0800, S. Aguinaga wrote:
> Thank you, I went to the site and downloaded everything (including the dependencies, to be able to build ffado) but ran into one problem: 
> The README file says to launch the daemon, but it fails:
> 
>   jackd -v  -d firewire
> getting driver descriptor from /usr/lib/jack/jack_alsa.so
> getting driver descriptor from /usr/lib/jack/jack_dummy.so
> getting driver descriptor from /usr/lib/jack/jack_freebob.so
> getting driver descriptor from /usr/lib/jack/jack_oss.so
> jackd: unknown driver 'firewire'

Do you have more than one version of jack installed, eg. one
in /usr/lib and one in /usr/local/lib? You might have seen
this already, but it's important:
http://subversion.ffado.org/wiki/AvoidingParallelInstallations.

If the documentation at ffado.org doesn't help you solve the
problem, the jack-devel mailing list might be a better place
to ask.

John
