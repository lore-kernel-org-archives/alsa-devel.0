From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH - hwmixvolume 4/9] hwmixvolume: use a with
 context to open files
Date: Tue, 14 Aug 2018 12:59:33 +0900
Message-ID: <f72c8a97-542f-85e6-de3d-3ee121f4aa72@sakamocchi.jp>
References: <20180808155637.5592-1-linkmauve@jabberfr.org>
 <20180808155637.5592-5-linkmauve@jabberfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180808155637.5592-5-linkmauve@jabberfr.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Emmanuel Gil Peyrot <linkmauve@jabberfr.org>, patch@alsa-project.org
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Aug 9 2018 00:56, Emmanuel Gil Peyrot wrote:
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> 
> diff --git a/hwmixvolume/hwmixvolume b/hwmixvolume/hwmixvolume
> index 267228c..e82f32d 100755
> --- a/hwmixvolume/hwmixvolume
> +++ b/hwmixvolume/hwmixvolume
> @@ -138,26 +138,20 @@ class Stream:
>               subdevice = info.index
>           filename = "/proc/asound/card%d/pcm%dp/sub%d/status" % (card, device, subdevice)
>           try:
> -            f = open(filename, "r")
> +            with open(filename, "r") as f:
> +                for line in f.readlines():
> +                    if line[:9] == "owner_pid":
> +                        return int(line.split(':')[1].strip())

I'm not oppose to use with (far from it I greatly prefer it.), however 
the with statement was firstly supported in Python 2.5:
https://docs.python.org/3.6/whatsnew/2.5.html#what-s-new-in-python-2-5

This mean that you drop python 2.4 or former, in this point I have no 
objections because it was already unsupported.

If you use Python 2.5 or later, you can use 'file()' instead of 
'open()'. Furthermore, FILE object returned by 'file()' (or 'open()') 
supports 'iterator' and you have no need to call '.readlines()' anymore,
thus:

```
 > +            with file(filename, "r") as f:
 > +                for line in f:
...
```

>           except IOError:
>               return None
> -        try:
> -            for line in f.readlines():
> -                if line[:9] == "owner_pid":
> -                    return int(line.split(':')[1].strip())
> -        finally:
> -            f.close()
>           return None
>   
>       def get_pid_cmdline(self, pid):
>           try:
> -            f = open("/proc/%d/cmdline" % pid, "r")
> +            with open("/proc/%d/cmdline" % pid, "r") as f:
> +                cmdline = f.read()
>           except IOError:
>               return None
> -        try:
> -            cmdline = f.read()
> -        finally:
> -            f.close()
>           return cmdline.replace('\x00', ' ').strip()
>   
>   class MixerWindow(Gtk.Window):

Regards

Takashi Sakamoto
