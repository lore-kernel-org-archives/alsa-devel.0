From: ljp <ljp@llornkcor.com>
Subject: Re: mutli channel
Date: Sat, 1 Feb 2003 19:50:32 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302011950.32643.ljp@llornkcor.com>
References: <200302011222.49280.ljp@llornkcor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200302011222.49280.ljp@llornkcor.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Saturday February 1 2003 12:22 pm, ljp wrote:
> 2) I am not real clear on how to use the mixer. What would be the bare
> minimum steps to get the main volume?

to answer my own question, perhaps. minimal to get volume:

snd_mixer_open
snd_mixer_attach
snd_mixer_selem_register
snd_mixer_load

for{} through the elements

if( snd_mixer_selem_is_active
if( snd_mixer_selem_has_common_volume
if( snd_mixer_selem_has_playback_volume

snd_mixer_selem_get_playback_volume


correct?
ljp



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
