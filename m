From: Dave Raggett <dsr@w3.org>
Subject: Advice on using ALSA with callbacks?
Date: Wed, 28 Dec 2005 18:10:11 +0000 (GMT)
Message-ID: <Pine.LNX.4.61.0512281715520.11482@holly>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am writing an audio streaming application for speech synthesis and 
recognition, and wish to take advantage of ALSA (my code currently 
uses OSS). The networking code is driven by the poll system call 
(see man poll) and uses ring buffers for reading and writing.

I would like to use call backs for when ALSA has captured a frame of 
audio data from the microphone, or when ALSA is ready for a frame of 
audio data for playback. I am using single channel audio with 8000 
samples a second and signed 16 bit linear little endian samples.

My expectation is that I don't need to access ALSA from a separate 
thread from the networking code that is driven with the poll system 
call. Once ALSA has been correctly initialized, it would result in 
asynchronous calls to the call back routines. I could then avoid the 
need for locks on the ring buffers that these routines share with 
the network code.

An alternative would be to provide a separate thread and for it to 
use blocking calls to ALSA, but this doesn't feel like the best way 
to go. It would also need one thread for playback and another for 
capture (for use with speech recognition). I am therefore keen to 
learn how to implement a single threaded callback solution.

The tutorials by Paul Davis are nice and clear, but unfortunately 
don't cover the use of call backs. Is there a relatively simple 
example program I could look at for what I need to do?

Any advice would be much appreciated.

- -- 
  Dave Raggett <dsr@w3.org>  W3C lead for multimodal interaction
  http://www.w3.org/People/Raggett +44 1225 866240 (or 867351)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDstUJb3AdEmxAsUsRAg7SAKDrE/hNJy5NxxAarr753gVOoE6qsgCcDfFR
KqdWbkiVDyvaEpcHsa5T8P4=
=jFug
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
