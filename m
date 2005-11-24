From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: question about pointer callback
Date: Thu, 24 Nov 2005 16:04:40 +0000
Message-ID: <ad2655cb0511240804v54226b71l@mail.gmail.com>
References: <009d01c5f101$2ab05e30$3d2aa8c0@Fiona>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.203])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0ED01C4
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 17:04:41 +0100 (MET)
Received: by nproxy.gmail.com with SMTP id d4so299027nfe
        for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 08:04:40 -0800 (PST)
In-Reply-To: <009d01c5f101$2ab05e30$3d2aa8c0@Fiona>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sverker Abrahamsson <sverker@abrahamsson.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 24/11/05, Sverker Abrahamsson <sverker@abrahamsson.com> wrote:
> Hi
> I have a (maybe stupid) question about the pointer callback and it's
> purpose. Is it used for both playback and capture? As I understand it sho=
uld
> return the availible data to read (for capture) in number of frames, but
> should it return the availible space to write to for playback also?
> /Sverker

If you mean the pointer callback in a sound card driver module, it
should point to the current possition of the ADC, DAC in the ring
buffer. So it is not "available data to read".


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
