From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Ameter plugin : looping sound
Date: Wed, 14 Dec 2005 17:25:30 -0500
Message-ID: <1134599131.12086.71.camel@mindpipe>
References: <1134598668.43a09a0cb1add@imp3-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1134598668.43a09a0cb1add@imp3-g19.free.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: laugeo2@free.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-12-14 at 23:17 +0100, laugeo2@free.fr wrote:
> Hi,
>  Ameter  is a metering plugin for Alsa :
> http://laugeo.free.fr/ameter.html
>  It stopped working since 1.0.10,and also fails with 1.0.11rc1 (was ok with
> 1.0.9) :
> Playing a sound with aplay (or any other program) cause  a short sound looping
> in audio out ,while  peakmeter displays the real soundfile level .
>  It seems that the looping sound is the end of the last played sound .
>  I have Mandriva 2005 (2.6.11 standard kernel),  ens1371 sound card.
> Somenone else has reported the problem ( I don't know his config) .
> 
> Test command:
> aplay -D ameter sound.wav -v
> It returns no error.

The easiest solution is to use ALSA CVS to do a binary search and find
out exactly which commit broke it.

I like to go by date as not all releases get tagged in CVS:

cvs update -D2005-11-01 -A

etc

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
