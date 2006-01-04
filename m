From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Wed, 4 Jan 2006 02:28:34 +0100
Message-ID: <20060104012834.GB46977@dspnet.fr.eu.org>
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <200601031716.13409.s0348365@sms.ed.ac.uk> <20060103192449.GA26030@dspnet.fr.eu.org> <43BAFBBD.9010206@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from dspnet.fr.eu.org (dspnet.fr.eu.org [213.186.44.138])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 45FFE181
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 02:28:35 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <43BAFBBD.9010206@superbug.demon.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 03, 2006 at 10:33:33PM +0000, James Courtier-Dutton wrote:
> Olivier Galibert wrote:
> >
> >As for the OSS API being crippled, I'd take the 3 ioctl calls you need
> >to setup a simple stereo 16bits output with OSS than the 13 ALSA
> >library calls anyday.  Especially with the impressive lack of
> >documentation you get about what the hell is a period, or what you can
> >do except aborting when you get an error.
> >
> 
> There is perfectly good documentation. You just have not bothered to 
> look at it.

Really?  Did you try finding documentation for the simple problem that
is playing dynamically generated stereo with minimum latency recently?
Because I did.  Hey, let's have fun and try it again.

Start with "alsa" is google, you find www.alsa-project.org.  Good
start.  Then you go to documentation.

Ok, let's check:

- Background info.... nah, no background info in there, only PR about
  why it's so much cooler that OSS.  Uninteresting.

- Tutorials.  Too bad they're all about 0.9, so they don't compile
  anymore.  At least they give a start, even if I'd loved to have an
  explanation of why there is writen and writei when there is
  set_access.  And they have zero information about error handling, or
  what the hell a period is (somthing like a buffer size?) or what is
  the impact of asking for multiple ones.

- Doxygen-generated reference documentation.  The API links start
  quite badly, but thankfully the PCM interface one is not empty, and it
  is not even that bad.  It is missing some relatively important things
  though, like:

  - High-level view of the application structure.

  - Some explanation of the meaning of the most non-obvious calls like
    prepare.

  - Technical glossary.  F.i. what te hell a "configuration space" is?

  - Error returns, and what to do about them.  Especially from things
    like prepare or poll_description_revents where it seems it should
    never happen.

  - Pointer on how to do simple but rather useful things, like getting
    the minimum latency possible, getting the list of devices, getting
    their capabilities (channels, hardware-supported frequencies and
    formats, modem vs. soundcard...)


> The ALSA api is good enough so you can actually decide what happens when 
> you get an error. e.g. an over or under run. You can tell ALSA to stop 
> the stream, or you can tell is to continue on just using silence frames 
> until you send it some new sounds.
> The OSS API cannot achieve that.

Talk about throwing the baby with the bathwater.

  OG.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
