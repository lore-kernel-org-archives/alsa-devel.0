From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Error: firmware not found
Date: Wed, 26 Jan 2005 18:29:42 +0100 (CET)
Message-ID: <XFMail.20050126182942.pochini@shiny.it>
References: <s5hvf9lplgh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvf9lplgh.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>Alsa-devel <alsa-devel@lists.sourceforge.net>, Thierry Vignaud <tvignaud@mandrakesoft.com>
List-Id: alsa-devel@alsa-project.org


On 25-Jan-2005 Takashi Iwai wrote:

>> The ALSA driver exits if the box is wrong. The obvious solution is to do
>> that same procedure in the ALSA driver, but it implies I have to replace
>> all references to card capabilites (# of channels, etc...) with variables.
>> Those vars never change their values after init. Furthermore a few
>> functions are different. I worked a lot to do as much choices as possible
>> at compile time. Currently they're all constants.
>
> Well, but if it's the only method to initialize the stuff
> automatically, the procedure above seems to be the only to go.
>
> This is no urgent issue, but should be fixed before submitting to
> linux kernel.

*sigh* I'll do some tests in the weekend to see how much
is the impact of making all that stuff variable in terms
of binary size and mess in the sources. Maybe I can fix
it with some not very nice #define...

Btw, I don't see what is the problem of having two drivers
for the same ID. Does it break some rule ?  Actually, the
problem is there are two different (though similar) devices
with the same IDs :-/


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
