From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: [PATCH] pmac 48kHz sample rate not function -> disable
Date: Wed, 4 Aug 2004 09:49:48 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408040949.49136.bergtroll@gmx.li>
References: <410A61AC.80008@gmx.net> <s5h4qnlu857.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qnlu857.wl@alsa2.suse.de>
Content-Disposition: inline
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

On Mon, 02 Aug 2004 22:49, Takashi Iwai wrote:
> At Fri, 30 Jul 2004 16:56:44 +0200,
>
> Rene Rebe wrote:
> > Hi all,
> >
> > 48kHz sample rate is not functional - at least with all iBook2s I
> > have access to. The hardware just does 44.1kHz instead. I have cross
> > checking the Darwin source - but as far as I have seen it also does
> > not support higher rates then 44.1kHz. Strange is, that any bit
> > combination written does result in 44.1kHz. Maybe someone with access
> > to the spec can implement it correctly - if the hardware does support
> > something different.
>
> I guess it's iBook2-specific.  Any other users?
AFAIK, none of the pmac chips supports anything other than 44.1kHz. In OS 
X CoreAudio takes care of resampling, I think...



Cheers,

Niklas
--
Computer Music PhD-student
University of Waikato
Hamilton
New Zealand


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
