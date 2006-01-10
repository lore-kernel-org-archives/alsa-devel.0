From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA - pnp OS bios option
Date: Tue, 10 Jan 2006 10:01:33 +0100
Message-ID: <1136883693.43c377ed83361@www.domainfactory-webmail.de>
References: <200601092022.56244.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200601092022.56244.nick@linicks.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nick Warne wrote:
> 00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
>
> If I turn OFF PNP OS, when I boot, 'alsactl restore' (run from
> rc.local) squinnies:
>
> Set_Control:894 Name mismatch ... Control #47
> 896: Index mismatch (0/0) for Control #47
> 1008: Bad control.47.value

This usually happens when you use a different driver version that has
different mixer controls so that the saved state in /etc/asound.state
doesn't match.

I don't know why the "PNP OS" setting should affect which mixer
controls are available.  What are the differences in /etc/asound.state
after "alsactl store" in both cases?


Clemens



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
