From: rob buse <rcbuse@filter24.org>
Subject: re: sequencer client subscription problem (nevermind)
Date: Fri, 16 Aug 2002 00:20:39 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020816042039.GA1328@filter24.mshome.net>
References: <20020815211735.GA1559@filter24.mshome.net>
Reply-To: rcbuse@filter24.org
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020815211735.GA1559@filter24.mshome.net>
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


sorry for the bandwidth, I just solved my problem.
I didnt realize that you had to call snd_seq_connect_from().
In case anyone was wondering :) 
.rob

> 
> Hello All,
> 
> I have a small problem that I cant figure out.  Basically, on startup 
> I'm having
> my sequencer run through the alsa clients with 
> snd_seq_query_next_client() and
> snd_seq_query_next_port(). I look for clients with 
> SND_SEQ_PORT_CAP_SUBS_WRITE for
> output and SND_SEQ_PORT_CAP_SUBS_READ for input, and connect to them 
> accordingly.
> 
> Now, perhaps the subscribe mechanism dosnt work the way I think it 
> does...
> 
> my code works for my sblives midi input.  But when vkeybd is running, 
> its flags
> are set as follows:
> 
> [128:  0 Virtual Keyboard Virtual Keyboard]
> SND_SEQ_PORT_CAP_READ
> SND_SEQ_PORT_CAP_SUBS_READ SND_SEQ_PORT_TYPE_MIDI_GENERIC
> SND_SEQ_PORT_TYPE_APPLICATION
> 
> then I open my own port with the flags :
> 
> [129:  6 seq24 seq24 in port]
> SND_SEQ_PORT_CAP_READ
> SND_SEQ_PORT_CAP_NO_EXPORT
> SND_SEQ_PORT_TYPE_MIDI_GENERIC
> SND_SEQ_PORT_TYPE_APPLICATION All other subscriptions work, but when I 
> issue a snd_seq_connect_to() from the seq24
> port to the vkey port, it fails.
> do I need to do more to my port in order to subscribe to an applications 
> port ?
> 
> 
> Thanks!
> .rob buse
> 
> 
> 
> 
> ----------------------------------------------------------
> music + technology                     http://filter24.org

----------------------------------------------------------
music + technology                     http://filter24.org


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
