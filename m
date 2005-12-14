From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC] Zero-conf ALSA
Date: Wed, 14 Dec 2005 17:28:42 -0500
Message-ID: <1134599323.12086.77.camel@mindpipe>
References: <1132805024.1921.48.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1132805024.1921.48.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-11-23 at 23:03 -0500, Lee Revell wrote:
> I would like to gather a list of the work remaining to be done to
> achieve "zero-conf" ALSA.  With the increasing maturity of dmix and
> softvol we are very close to this goal, and should be able to provide
> basic soundcard functionality that users expect (mixing, volume control,
> and OSS emulation) without requiring them to delve into cryptic config
> files.
> 
> I propose to open a tracking bug in the ALSA BTS to gather all reports
> of end users having to modify the config to get a working setup.  AFAICT
> the remaining problems are:
> 
>   1. Devices which require dmix and/or softvol but are lacking the required 
>      entries in the /usr/share/alsa/cards/ file.
>   2. User-space OSS emulation over dmix requires period and the buffer sizes 
>      to be set to powers of two.

Another thing that's been pointed out is 5.1 upmixing of stereo sources.
How much work would it be to have this work OOTB for devices that can't
do it in hardware?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
