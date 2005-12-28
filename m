From: Dave Raggett <dsr@w3.org>
Subject: Re: Advice on using ALSA with callbacks?
Date: Wed, 28 Dec 2005 18:27:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.61.0512281819110.11482@holly>
References: <Pine.LNX.4.61.0512281715520.11482@holly>
 <Pine.LNX.4.61.0512281912160.9509@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0512281912160.9509@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 28 Dec 2005, Jaroslav Kysela wrote:

> On Wed, 28 Dec 2005, Dave Raggett wrote:
>
>> The tutorials by Paul Davis are nice and clear, but unfortunately 
>> don't cover the use of call backs. Is there a relatively simple 
>> example program I could look at for what I need to do?
>>
>> Any advice would be much appreciated.
>
> My advice is to use poll() also for the audio data. It's not really
> required to use an asynchronous source for your application.
>
> 						Jaroslav

Thanks for the swift response.

I am currently using poll() with OSS but don't understand how
to get this to make this work with ALSA. In OSS it is easy
to get a file descriptor for use with poll by opening /dev/audio.
Is there something analogous for use with ALSA?  Can ALSA be
set up in such a way that poll only sees the file descriptor
as ready for reading when a complete frame is available, and
likewise to only become ready for writing when there is space
for a complete frame of playback data?

Many thanks,
- -- 
  Dave Raggett <dsr@w3.org>  W3C lead for multimodal interaction
  http://www.w3.org/People/Raggett +44 1225 866240 (or 867351)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDstkcb3AdEmxAsUsRAqRKAKDSCtSyFjYb+hlwvQWX105kmQ1rtQCgpawS
Ovz++sL1MJAG6+O7xc5P/UE=
=SmNZ
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
