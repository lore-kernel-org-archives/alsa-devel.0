From: gerlacbd <gerlacbd@emt.iis.fhg.de>
Subject: Q:  Error on compiling/linking
Date: Thu, 09 Oct 2003 18:08:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8587F0.1070902@emt.iis.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello,

I'm new to ALSA and I have a problem on programming the library:
On my system ALSA library 0.9.7 and ALSA 0.9.7 driver is installed. 
According to the api-documentation on the ALSA project site, I tried to 
do something like:

snd_seq_client_info_t *info;
snd_seq_client_info_malloc ( &info );
snd_seq_get_client_info( seq_handle, info );

... do sth. like readout name with snd_seq_client_info_get_name( info );

snd_seq_client_info_free ( info );

When compiling/linking, I receive:
"undefined reference to `snd_seq_client_info_malloc'"
Same for snd_seq_client_info_get_name and for snd_seq_client_info_free.

What's wrong? Is'nt my lib up to date? (I read that the sequencer api 
has been rewritten with get/set functions, but in which version?)

Thanks for answers or links to some introduction sites.

Berhnard


-- 

---------------------------------
Bernhard Gerlach
Fraunhofer AEMT
Am Helmholtzring 1 (Haus M)
98693 Ilmenau
Germany

mail: gerlacbd@emt.iis.fhg.de
---------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
