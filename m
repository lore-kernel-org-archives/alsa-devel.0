From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: hw pause in USB
Date: Tue, 03 Jan 2006 16:19:58 -0800
Message-ID: <43BB14AE.4030400@pianodisc.com>
References: <DB99F0250CDF5F438C525F4695C888DC0DA011@exchange01-srv.pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <DB99F0250CDF5F438C525F4695C888DC0DA011@exchange01-srv.pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <ladischc@informatik.uni-halle.de>
List-Id: alsa-devel@alsa-project.org

We've got it licked.  The most recent issue was a thread synchronization issue, where our pcm writing thread was putting data into the pcm AFTER we "paused" it and corrupting both the pcm and our "save" ring buffer.  After inserting a mutex all was well.

Thanks for your help in figuring out how to implement a software emulated pause.  

Now all I need is that time to write that high-level basic sound library. :)

- Steve



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
