From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How to display mixer controls to the user? was:Re:
	[PATCH/RFC] emu10k1 multichannel PCM
Date: Mon, 15 Nov 2004 12:29:33 -0500
Message-ID: <1100539773.3669.14.camel@krustophenia.net>
References: <200411151349.iAFDnTj8024003@www3.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411151349.iAFDnTj8024003@www3.pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: James@superbug.co.uk, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-11-15 at 14:49 +0100, Peter Zubaj wrote:
> > .....
> 
> emu10k1 is only one chip with complex mixer without own mixer app.
> 

Yeah this was going to be my other suggestion.  But, if there are plans
to improve the ALSA mixer API in the near future, this might be wasted
effort.  Maybe it is not possible to have a powerful enough mixer API to
work for any card.

If the ALSA mixer API is not intended to be enough for complex devices,
then this is fine. we can write an emumixer app.  This seems to be how
it works on Windows - simple devices just use the generic Windows mixer,
others have their own custom mixer app.  For example every ASIO driver
is required to implement a control panel.

Anyway since we need hwdep apps like the DSP loader and soundfont stuff
anyway, maybe it would just be easiest to subsume the emu10k1 mixer into
qlo10k1 like the kX driver does.

That being said I still think containers for mixer elements would be an
easy and useful enhancement to the mixer API.  We could at least
eliminate confusion by distinguishing 'Advanced' from 'Standard'
controls and stuffing the former in the 'Advanced' menu.  Most users
only touch 3 or 4 mixer elements, ever.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
