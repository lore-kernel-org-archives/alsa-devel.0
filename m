From: Laurielle LEA <lauriellelea@yahoo.fr>
Subject: Open device with mode read/write
Date: Fri, 4 Feb 2005 16:50:40 +0100 (CET)
Message-ID: <20050204155040.54746.qmail@web25107.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hi all,

I'm trying to integrate the ALSA driver to my SIP user
agent.
I would like to open the device in read/write open
mode.

To write it's :
snd_pcm_open (&audio_hdl, ALSA_DEVICE,
SND_PCM_STREAM_PLAYBACK,0);=20
And to read it's:
snd_pcm_open (&audio_hdl, ALSA_DEVICE,
SND_PCM_STREAM_CAPTURE,0);

But how can I open with PLAYBACK and CAPTURE stream?
Is it possible?

Thanks in advance.
Laurielle.


=09

=09
	=09
D=E9couvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos=
 mails !=20
Cr=E9ez votre Yahoo! Mail sur http://fr.mail.yahoo.com/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
