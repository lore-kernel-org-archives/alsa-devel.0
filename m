From: Antonio Willy Malara <behappy@maialone.com>
Subject: usb-audio
Date: Mon, 27 Oct 2003 19:03:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031027180300.GA5016@Zeryn>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

When is it planned the fix of the usb-audio driver for big endian 
machines? I'm refferring particularly to that:

	/* FIXME: correct endianess and sign? */

(in function parse_audio_format_i_type (); at line 1990 in file alsa-
kernel/usb/usbaudio.c version 1.67)

Willy


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
