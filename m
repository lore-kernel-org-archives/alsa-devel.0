From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Open device with mode read/write
Date: Fri, 4 Feb 2005 16:55:22 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502041653370.13899-100000@studcom.urz.uni-halle.de>
References: <20050204155040.54746.qmail@web25107.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050204155040.54746.qmail@web25107.mail.ukl.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Laurielle LEA <lauriellelea@yahoo.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Laurielle LEA wrote:
> agent.
> I would like to open the device in read/write open
> mode.
>
> To write it's :
> snd_pcm_open (&audio_hdl, ALSA_DEVICE,
> SND_PCM_STREAM_PLAYBACK,0);
> And to read it's:
> snd_pcm_open (&audio_hdl, ALSA_DEVICE,
> SND_PCM_STREAM_CAPTURE,0);
>
> But how can I open with PLAYBACK and CAPTURE stream?

Just use two handles.  A PCM handle always is for only one direction.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
