From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Azalia/ICH6-HDA mixer support?
Date: Thu, 25 Nov 2004 12:35:21 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411251234200.15923-100000@studcom.urz.uni-halle.de>
References: <DBFABB80F7FD3143A911F9E6CFD477B0033AD80D@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B0033AD80D@hqemmail02.nvidia.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephen Warren <SWarren@nvidia.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote:
> One thing I did notice - alsamixer usually displays text for "Chip" in
> the top-left, but doesn't on this system - just "Card: ICH6 HDA" and
> "Chip:" is left blank. Is it not detecting the codec chip correctly?

The driver just does't bother to set this string.

> The problem I'm having is that alsamixer only shows the following three
> columns:
>
> "Line", "Mic", "Capture"
>
> Is this a hardware limitation (always line level out or
> something?) or just missing functionality in the driver, since
> it's very new?

The latter.


Best regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
