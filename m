From: Frans Ketelaars <ketelaars@wanadoo.nl>
Subject: Re: rc3 doesn't compile
Date: Wed, 21 Aug 2002 23:42:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020821234207.6be1df05.ketelaars@wanadoo.nl>
References: <20020821194353.77069.qmail@web11507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.wanadoo.nl (smtp3.wanadoo.nl [194.134.35.186])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA04379
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2002 23:47:50 +0200
In-Reply-To: <20020821194353.77069.qmail@web11507.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Adam Jones <alsa@yggdrasl.demon.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Aug 2002 12:43:53 -0700 (PDT)
Guilhem Tardy <guilhem_tardy@yahoo.com> wrote:

> Hi,
> 
> Is this a common occurence that rc3 doesn't compile?
> In my case, there are all sorts of isa-pnp related functions that have already
> been defined. Note that I did NOT turn isa-pnp ON (the INSTALL files implies
> default is OFF).
> 
> Regards,
> Guilhem.

--------------------------------------------------------------------------
From: Adam Jones <alsa@yggdrasl.demon.co.uk>
To: alsa-user ML <alsa-user@lists.sourceforge.net>
Reply-To: adam@yggdrasl.demon.co.uk
Subject: [Alsa-user] Re: driver 0.5.12a fails compile with arch=i486
Date: Mon, 19 Aug 2002 06:17:00 +0100
Sender: alsa-user-admin@lists.sourceforge.net
Organization: Z'ha'dum Asteroid Mining Corp
X-Mailer: YAM 2.3 [040] AmigaOS E-Mail Client (c) 1995-2000 by Marcel Beck  http://www.yam.ch/

On 18-Aug-02, Tom Whiting wrote:

> On Sunday 18 August 2002 05:24 pm, Frans Ketelaars wrote:
>> *** N.B. The 0.5.x series is considered deprecated and is no longer
>> supported by ALSA developers ***
> Sadly, the Release Candidates don't even compile on all machines

I think Takashi's already spotted this issue:

> looks like a wrong file came into rc3 tarball accidentally.
> for compiling rc3 alsa-driver, please remove the file
> 
>     alsa-driver-0.9.0rc3/include/linux/isapnp.h
> 
> before running configure script.

Personally I'd suggest that a compile failure merits updating the
tarballs on the front page - 0.9.0rc3a or something like that - because
compilation failures are guaranteed to put people off ALSA for good.
-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
---------------------------------------------------------------------------

HTH,

    -Frans


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
