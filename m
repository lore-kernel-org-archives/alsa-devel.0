From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Question: setting up the hardware for alsa
Date: Sat, 05 Nov 2005 19:45:02 -0500
Message-ID: <1131237903.6781.22.camel@mindpipe>
References: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Smoot <davidsmoot@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-11-04 at 09:49 -0600, David Smoot wrote:
> 5.  I copied libasound to my libraries folder.
> 
> At this point I at least knew libasound was OK because I could
> execute some simple code that listed libasound data types and
> parameters.
> 
> But I can't open any devices and talk to them.  I know I am missing
> some kind of crucial step in setting up the hw:0,0 device but I can't
> seem to figure out the next step.  I've read tutorials, googled, but I
> am stuck.  If someone would point me to the proper documents I would
> be grateful.
> 

Ah, this is the problem.  It's not sufficient to just copy the libasound
binary into your LD_LIBRARY_PATH.  Alsa-lib needs these files too:

/usr/share/alsa/alsa.conf
/usr/share/alsa/pcm/*
/usr/share/alsa/cards/*

Why not just run "make install" instead of trying to install alsa-lib by
hand?

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
