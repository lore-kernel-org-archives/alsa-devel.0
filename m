From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: alsa-lib: snd_device_name_hint() function
Date: Wed, 11 Oct 2006 14:03:48 +0100
Message-ID: <20061011130347.GB3038@palantir8>
References: <Pine.LNX.4.61.0610111323470.8848@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mra02.ch.as12513.net (mra02.ch.as12513.net [82.153.254.70])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2E469141
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Oct 2006 15:03:25 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610111323470.8848@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav, Takashi,

I'd rather err on being more vebose here. While it is true displaying
all of them increases the chance of (mostly newbies) picking the wrong
device, but it also avoids people claiming they do not have those devices.

Just my 0.02 cents :)
Martin

On Wed, Oct 11, 2006 at 01:45:53PM +0200, Jaroslav Kysela wrote:
> Please, because I and Takashi have different meaning about the default 
> behavior, if definitions of devices should be visible by default or not, 
> let us know (to this mailing list) your meaning. I'll gather your votes 
> and change behaviour of alsa-lib (if required).
> 
> Proposals:
> 
> a) my implementation - device definitions in ~/.asoundrc are listed
>    by default and user can disable listing using 'hint 0' in the
>    device definition
> b) Takashi's proposal - if the hint {} section is missing, the device
>    will not be listed

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
