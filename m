From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: possible ALSA bug/feature (was: important recording
 broke. why?) (fwd)
Date: Thu, 27 Mar 2003 02:42:32 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303270240430.3682-100000@ecabase.localdomain>
References: <s5h7kanpbpc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kanpbpc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, The Eye <the.eye@gmx.li>
List-Id: alsa-devel@alsa-project.org

On Tue, 25 Mar 2003, Takashi Iwai wrote:

>> It seems that with newer ALSA versions, snd_pcm_read[in]()  sometimes
>> returns -EIO even though documentation says nothing about this. After some
> i also don't know whether Jaroslav added as a feature or as an
> unexpected bug.  anyway, this means that the poll failed and the pcm
> status is abnormal, typically xruns...
[...]
> how about the attached patch?  (untested)

Works fine here - no more -EIOs and recording is ultra-reliable again! :)

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
