From: Joe Hsu <nagual.hsu@gmail.com>
Subject: Re: What's the right way to do??? resample??
Date: Fri, 1 Apr 2005 09:34:21 +0800
Message-ID: <7fe20599050331173415fe08ac@mail.gmail.com>
References: <7fe2059905033018492546d763@mail.gmail.com>
	 <424C0ADF.3040306@cubic.org>
Reply-To: Joe Hsu <nagual.hsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <424C0ADF.3040306@cubic.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk Jagdmann <doj@cubic.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 31 Mar 2005 16:36:15 +0200, Dirk Jagdmann <doj@cubic.org> wrote:
> You have to sync your hardware for input and output. That either means
> you have to use a hardware which provides both input and output and full
> duplex access or you have to use an external word clock cable to
> synchronisation. Then on the software side you can be sure, that your
> output will always consume the exact amount of data the input has just
> generated.

Thanks.

Actually I record from bt878 and play it back on AC97. So
what do you mean by "external world clock" in this case?
Is /dev/rtc an sort of external world clock? Or you just 
mean there is no solution without hardware modifications
in such a case??

-- 
The sun is shinny but the ice is slippery.


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
