From: Fredrik Lingvall <fl@ifi.uio.no>
Subject: Re: [OctDev] Updated ALSA and a new JACK package for
 playing and recording audio
Date: Fri, 02 Sep 2011 09:31:10 +0200
Message-ID: <4E60863E.3030202@ifi.uio.no>
References: <CALoH2qeObxjWyyf9ARMtFrVYQ4WpFLs5BbgfCbOj0COR1bxd9w@mail.gmail.com>
	<CA+NOx6b8Q6F3UNG5A_O=farWPWKn35zgDCQCGWCj3a5YWYW9uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 76B9A103881
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 09:31:15 +0200 (CEST)
Received: by bkar19 with SMTP id r19so2416395bka.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Sep 2011 00:31:14 -0700 (PDT)
In-Reply-To: <CA+NOx6b8Q6F3UNG5A_O=farWPWKn35zgDCQCGWCj3a5YWYW9uA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miguel Bazdresch <eorlinga@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Fredrik Lingvall <fredrik.lingvall@gmail.com>
List-Id: alsa-devel@alsa-project.org

Miguel,

I have updated the alsa package now and I don't have any build issues on
my machine:

octave:3> pkg install aaudio-0.2.1.tar.gz
warning: creating installation directory /usr/share/octave/packages
octave:4>

Check that the clock is set correctly on your machine (is ntp-client
running?)

Also,  test to do a

octave:4> pkg uninstall aaudio

and then install aaudio again.

You should have:

octave:4> pkg list
Package Name  | Version | Installation directory
--------------+---------+-----------------------
      aaudio *|   0.2.1 | /usr/share/octave/packages/aaudio-0.2.1

after installation.

/Fredrik



On 09/01/11 21:53, Miguel Bazdresch wrote:
> On Thu, Sep 1, 2011 at 12:29 PM, Fredrik Lingvall <fl@ifi.uio.no> wrote:
>> Ah, I forgot to remove that line from the Makefile.
>>
>> You can fix it by uncompressing the tar file, edit the Makefile in the src
>> folder, remove all  actrecord stuff, and recomress it again. I will fix this
>> tomorrow.
>>
>> /Fredrik
> Fredrik,
>
> After removing all references to actrecord, I got:
>
> octave:1> pkg install /home/miguel/Sources/aaudio-0.2.0.tar.gz
> warning: load_path:
> /home/miguel/octave/aaudio-0.2.0/i686-pc-linux-gnu-api-v45+: No such
> file or directory
> /home/miguel/octave/aaudio-0.2.0/i686-pc-linux-gnu-api-v45+/aplayrec.oct:
> failed to load:
> /home/miguel/octave/aaudio-0.2.0/i686-pc-linux-gnu-api-v45+/aplayrec.oct:
> undefined symbol: snd_pcm_sw_params_set_start_threshold
> error: called from `gen_doc_cache>create_cache' in file
> /usr/share/octave/3.4.2/m/help/gen_doc_cache.m near line 93, column 17
> error: called from:
> error:   /usr/share/octave/3.4.2/m/pkg/pkg.m at line 832, column 5
> error:   /usr/share/octave/3.4.2/m/pkg/pkg.m at line 361, column 9
> octave:1>
>
> If I try to run a command I get:
>
> octave:1> aplay
> warning: load_path:
> /home/miguel/octave/aaudio-0.2.0/i686-pc-linux-gnu-api-v45+: No such
> file or directory
> warning: timestamp on file
> /home/miguel/octave/aaudio-0.2.0/i686-pc-linux-gnu-api-v45+/aplay.oct
> is in the future
> error: /home/miguel/octave/aaudio-0.2.0/i686-pc-linux-gnu-api-v45+/aplay.oct:
> failed to load:
> /home/miguel/octave/aaudio-0.2.0/i686-pc-linux-gnu-api-v45+/aplay.oct:
> cannot open shared object file: No such file or directory
> octave:1>
>
> Cheers,
>
