From: "Jonathan Gage" <chimera@darkscape.net>
Subject: Audiophile USB cat stream info
Date: Thu, 22 May 2003 18:37:49 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <01a301c3203d$6debf520$3700a8c0@jono>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Here is the output for stream0 and 1 using alsa 0.9.3c and 0.9.0rc5. The
front panel midi jacks work with version 0.9.3c but not version 0.9.0rc5.
Audio output does not work (properly) for 0.9.3c, upon sending a signal one
just hears digital noise. However with 0.9.0rc5 audio seems to work fine,
sounds files play correctly. As I said in a previous email to the list,
audio output is either silent of one simply hears digital noise on drivers
later than 0.9.0rc5.

_____alsa 0.9.3c /proc/asound/card0/stream0 output

bash-2.05a# cat stream0
M-Audio Audiophile USB (tm) at 002/003 : USB Audio

Playback:
  Status: Stop
  Interface 2
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 2
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 2
    Altset 3
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continuous)
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 2
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continuous)

Capture:
  Status: Stop
  Interface 5
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 48001 - 96000 (continuous)
  Interface 5
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 5
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)

_____alsa 0.9.3c /proc/asound/card0/stream1 output

bash-2.05a# cat stream1
M-Audio Audiophile USB (tm) at 002/003 : USB Audio #1

Playback:
  Status: Stop
  Interface 3
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 3
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 4 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 3
    Altset 3
    Format: S24_3LE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continuous)
  Interface 3
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 4 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 3
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continuous)
  Interface 3
    Altset 6
    Format: S16_LE
    Channels: 2
    Endpoint: 4 OUT (SYNC)
    Rates: 8000 - 48000 (continuous)

Capture:
  Status: Stop
  Interface 4
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 48001 - 96000 (continuous)
  Interface 4
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 4
    Altset 3
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 4
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 4
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 8000 - 48000 (continuous)

- - - - - - - - - - - - - - - - - - - -

_____alsa 0.9.0rc5 /proc/asound/stream0

bash-2.05a# cat stream0
M-Audio Audiophile USB (tm) : USB Audio

Playback:
  Status: Stop
  Interface 2
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continous)
  Interface 2
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continous)
  Interface 2
    Altset 3
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continous)
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continous)
  Interface 2
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continous)

Capture:
  Status: Stop
  Interface 5
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 48001 - 96000 (continous)
  Interface 5
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000 - 48000 (continous)
  Interface 5
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000 - 48000 (continous)

_____alsa 0.9.0rc5 /proc/asound/stream1

bash-2.05a# cat stream1
M-Audio Audiophile USB (tm) : USB Audio #1

Playback:
  Status: Stop
  Interface 3
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continous)
  Interface 3
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 4 OUT (ASYNC)
    Rates: 8000 - 48000 (continous)
  Interface 3
    Altset 3
    Format: S24_3LE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continous)
  Interface 3
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 4 OUT (ASYNC)
    Rates: 8000 - 48000 (continous)
  Interface 3
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 4 OUT (ADAPTIVE)
    Rates: 8000 - 48000 (continous)

Capture:
  Status: Stop
  Interface 4
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 48001 - 96000 (continous)
  Interface 4
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continous)
  Interface 4
    Altset 3
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 8000 - 48000 (continous)
  Interface 4
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continous)
  Interface 4
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 8000 - 48000 (continous)


Hope that makes sense to someone!

Jonathan



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
