From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/ca0106 ca_midi.c,...
Date: Fri, 21 Oct 2005 12:45:53 +0100
Message-ID: <4358D4F1.6020602@superbug.co.uk>
References: <E1ESiQD-0008Jo-Eq@sc8-pr-cvs1.sourceforge.net> <s5hll0ni3ui.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hll0ni3ui.wl%tiwai@suse.de>
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
Cc: Tilman Kranz <tilde@tk-sls.de>, James Courtier-Dutton <jcdutton@users.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>
>But, what is the reason to call them indirectly via pointers at all?
>The routine is just for ca0106, so no complex abstraction is
>necessary.
>
>
>Takashi
>
>
>  
>
The same ca_midi.c file should work with the emu10k1x, sb live, sb 
audigy1/2.
Once this midi code is tested well, we can then share the code amongst 
all the different modules.
So the indirection is for that purpose.

James



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
