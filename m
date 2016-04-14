From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Tascam US-122L - Corrupt USB descriptor
Date: Thu, 14 Apr 2016 09:35:14 +0200
Message-ID: <570F4832.9020302__43559.4580173076$1460619365$gmane$org@ladisch.de>
References: <3d5a5368f3a43ffc0114daf09c306d7e.squirrel@mungewell.org>
 <570E0AE0.3020507@ladisch.de>
 <32e8a05d90e5cfd79622802c340948ab.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <32e8a05d90e5cfd79622802c340948ab.squirrel@mungewell.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-usb@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Simon Wood wrote:
> The card shows up under '/proc/asound/cards', but only as Midi.

Apparently, there is no PCM device. This driver creates a special
hardware-dependent device which is intended to be used with the
Jack driver "usb_stream".

It might be possible to use the ALSA "usb_stream" plugin:
<http://www.alsa-project.org/main/index.php/Matrix:Module-usb-us122l>


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
