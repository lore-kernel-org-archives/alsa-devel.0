From: "Loc Ho" <loc@pacificconsultants.com>
Subject: ALSA Memory Allocation Bug
Date: Wed, 12 May 2004 18:40:05 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <D22B281CC561444AA27F7F6C6C9E3E6102F546@mtvs4.pcllc.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

Hi,

I developed an custom USB Audio driver. In addition, I am also using the =
provided USB Audio driver for commercial USB Audio devices. After some =
testing with the custom USB Audio driver and the provided USB Audio =
driver, there seem to be a problem with the ALSA memory allocation =
routine. In file pcm_memory.c function setup_pcm_id, the id is generated =
using the pcm device ID, stream ID, and substream number. This only =
guarantee that the memory tag ID is unique for one card. If I have =
multiple cards, they will not be unique. Am I correct?

Thanks,
Loc


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
