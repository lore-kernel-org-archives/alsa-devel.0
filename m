From: Paulo Matias <syscoder@gmail.com>
Subject: Re: Re: Test model
Date: Thu, 16 Feb 2006 08:08:24 -0200
Message-ID: <acb0c1690602160208w1eb86af2uc38cb7592ba355ff@mail.gmail.com>
References: <20060215224941.GB11143@soften.ktu.lt>
	 <200602152348.k1FNm4nq021338@auster.physics.adelaide.edu.au>
	 <20060216092927.GA32525@soften.ktu.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060216092927.GA32525@soften.ktu.lt>
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
To: Rimas Kudelis <rq@akl.lt>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry for the delay again.

By the description of Rimas, I think we have the same Acer notebook,
or, at least, we've the same connections (mine is a TravelMate
4062WLMi, but I seriously suspect all TravelMate 4060 series has the
same hardware and connections, only varying in LCD size, RAM and HD
size, and presence of internal BlueTooth adapter). I had the same
problems he had and got sound from the same pins he got.

Jonathan, by your last email, I was thinking in a possibility. You
asked me about a external volume control. There are two keys at the
keyboard for increasing and decreasing the volume. They are Fn+Up
Arrow and Fn+Down Arrow. I was thinking in the possibility it
controls, via software, a volume control plugged in the out of the
codec. Is it possible?

Someone who has windows in this laptop could help, using this keyboard
controls and checking if it controls the mixer volume, or something
else. Rimas, do you have windows in your laptop? Can you please make
this check?

I've also taked a look at the windows drivers cd Acer provided. The
Realtek drivers installer has a directory called WDM that contains
.inf files that seems to contain the internal routings for varied
models. I haven't analysed it so much yet to confirm, but I can
provide the files on request.

Another thing I've perceived is that the drivers cd contains BlueTooth
drivers, and my model hasn't BlueTooth. This is an indication that the
same driver cd would be distributed for all TravelMate 4060 series, so
it would have the same hardware and same connections, and an ALSA
model for this notebook would work in all 4060 series.

Regards,
Paulo Matias


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
