From: Christian Esken <c.esken@cityweb.de>
Subject: alsa-lib: Error code 1 from snd_mixer_selem_set_capture_switch_all()
Date: Wed, 12 Nov 2003 13:03:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311121303.42282.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello,

I have a problem with snd_mixer_selem_set_capture_switch_all() from alsa-lib.
The documentation states:

/**
 * \brief Set value of capture switch control for all channels of a mixer 
simple element
 * \param elem Mixer simple element handle
 * \param value control value
 * \return 0 on success otherwise a negative error code
 */
int snd_mixer_selem_set_capture_switch_all(snd_mixer_elem_t *elem, int value)

So I should receive either 0 or a negative value. But I receive a return value 
of 1. Does anybody know what this means?!? Any help is appreciated greatly.

Greetings,
           Chris


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
