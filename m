From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: pcm_lib.c & pcm_memory.c
Date: Thu, 25 Jul 2002 12:27:07 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020725192707.4362.qmail@web11504.mail.yahoo.com>
References: <s5hbs8ypz6v.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs8ypz6v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > When does the pointer to the next playback/capture audio period rewind? I
> > noticed that for more than 2 periods_max, this can happen anytime
> > (eg. after 2, 3, ...) even before we reached the end of the buffer.
> 
> it must be after the hw_ptr reaches the end of the buffer.
> please check snd_pcm_update_hw_ptr_interrupt() in pcm_lib.c.

I am having a real hard time understanding
  snd_pcm_update_hw_ptr_interrupt()
  snd_pcm_lib_write_transfer()
  snd_pcm_lib_write1()
 and snd_pcm_lib_write()

For instance, it is not clear to me the relation between runtime->buffer_size
and runtime->boundary ?
What does runtime->hw_ptr_base ?
Should the pointer function wrap at buffer_size, like this:
	pos += data_sent;
	if (pos == buffer_size)
		pos = 0;

Lastly, I have a card that defines the on-board maximum buffer size in samples,
not in bytes. This is the cause of some trouble because the structure
snd_pcm_hardware_t doesn't support such a thing as a buffer_size_max - do you
have any suggestion? As of now, I define buffer_bytes_max for a specific format
(ie. LE16).

Thanks,
Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
