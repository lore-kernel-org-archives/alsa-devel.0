From: Tobias Peters <tpeters@uni-oldenburg.de>
Subject: usb sampling rate (Re: start_threshold having no
 effect)
Date: Tue, 28 Oct 2003 08:56:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1AEOiU-0000Cp-00@hpux02.hrz.uni-oldenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 21 Oct 2003 14:26:24 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> but 1ms period alignment is important:  if you want a RT process with
> the USB audio device, choose the sample rate with multiple of 1000.
> for example, avoid 44.1kHz, but use 48k instead.

Wouldn't the clocks of the usb and of the d/a converter get out sync
anyway, because of the drift? Why is a multiple of 1000 important then?

  Tobias



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
